require 'rdf'
require 'hamster'

module RDF
  class AcidRepository < Repository
    DEFAULT_GRAPH = false

    def initialize(*)
      @data = Hamster::Hash.new
      super
    end

    ##
    # @private
    # @see RDF::Enumerable#supports?
    def supports?(feature)
      case feature.to_sym
      when :graph_name   then @options[:with_graph_name]
      when :inference then false  # forward-chaining inference
      when :validity  then @options.fetch(:with_validity, true)
      else false
      end
    end

    ##
    # @private
    # @see RDF::Countable#count
    def count
      count = 0
      @data.each do |g, ss|
        ss.each do |s, ps|
          ps.each do |p, os|
            count += os.size
          end
        end
      end
      count
    end

    ##
    # @private
    # @see RDF::Enumerable#has_statement?
    def has_statement?(statement)
      s, p, o, g = statement.to_quad
      g ||= DEFAULT_GRAPH

      @data.has_key?(g) &&
        @data[g].has_key?(s) &&
        @data[g][s].has_key?(p) &&
        @data[g][s][p].include?(o)
    end

    ##
    # @private
    # @see RDF::Enumerable#each_statement
    def each_statement(&block)
      if block_given?
        # Note that to iterate in a more consistent fashion despite
        # possible concurrent mutations to `@data`, we use `#dup` to make
        # shallow copies of the nested hashes before beginning the
        # iteration over their keys and values.
        @data.each do |g, ss|
          ss.each do |s, ps|
            ps.each do |p, os|
              os.each do |o|
                # FIXME: yield has better performance, but broken in MRI 2.2: See https://bugs.ruby-lang.org/issues/11451.
                block.call(RDF::Statement.new(s, p, o, graph_name: g.equal?(DEFAULT_GRAPH) ? nil : g))
              end
            end
          end
        end
      end
      enum_statement
    end
    alias_method :each, :each_statement

    protected

    ##
    # Match elements with `eql?`, not `==`
    #
    # `graph_name` of `false` matches default graph. Unbound variable matches
    # non-false graph name
    #
    # @private
    # @see RDF::Queryable#query_pattern
    def query_pattern(pattern, options = {}, &block)
      if block_given?
        graph_name  = pattern.graph_name
        subject     = pattern.subject
        predicate   = pattern.predicate
        object      = pattern.object

        cs = @data.has_key?(graph_name) ? { graph_name => @data[graph_name] } : @data

        cs.each do |c, ss|
          next unless graph_name.nil? ||
                      graph_name == false && !c ||
                      graph_name.eql?(c)

          ss = if ss.has_key?(subject)
                 { subject => ss[subject] }
               elsif subject.nil? || subject.is_a?(RDF::Query::Variable)
                 ss
               else
                 []
               end
          ss.each do |s, ps|
            next unless subject.nil? || subject.eql?(s)
            ps = if ps.has_key?(predicate)
                   { predicate => ps[predicate] }
                 elsif predicate.nil? || predicate.is_a?(RDF::Query::Variable)
                   ps
                 else
                   []
                 end
            ps.each do |p, os|
              next unless predicate.nil? || predicate.eql?(p)
              os.each do |o|
                next unless object.nil? || object.eql?(o)
                yield RDF::Statement.new(s, p, o, graph_name: c.equal?(DEFAULT_GRAPH) ? nil : c)
              end
            end
          end
        end
      else
        enum_for(:query_pattern, pattern, options)
      end
    end

    ##
    # @private
    # @see RDF::Mutable#insert
    def insert_statement(statement)
      raise ArgumentError, "Statement #{statement.inspect} is incomplete" if statement.incomplete?

      unless has_statement?(statement)
        s, p, o, c = statement.to_quad
        c ||= DEFAULT_GRAPH

        @data = @data.put(c) do |subs|
          subs = (subs || Hamster::Hash.new).put(s) do |preds|
            preds = (preds || Hamster::Hash.new).put(p) do |objs|
              (objs || Hamster::Set.new).add(o)
            end
          end
        end
      end
    end

    ##
    # @private
    # @see RDF::Mutable#delete
    def delete_statement(statement)
      if has_statement?(statement)
        s, p, o, g = statement.to_quad
        g = DEFAULT_GRAPH unless supports?(:graph_name)
        g ||= DEFAULT_GRAPH

        os    = @data[g][s][p].delete(o)
        ps    = os.empty? ? @data[g][s].delete(p) : @data[g][s].put(p, os)
        ss    = ps.empty? ? @data[g].delete(s)    : @data[g].put(s, ps)
        @data = ss.empty? ? @data.delete(g)       : @data.put(g, ss)
      end
    end

    ##
    # @private
    # @see RDF::Mutable#clear
    def clear_statements
      @data = @data.clear
    end
  end
end
