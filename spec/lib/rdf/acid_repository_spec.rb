require 'spec_helper'
require 'rdf/spec/repository'

describe RDF::AcidRepository do
  it { expect(subject).to be_a RDF::Repository }
  
  let(:repository) { RDF::AcidRepository.new }
  it_behaves_like 'an RDF::Repository'

  # describe '#insert_statement' do
  #   it do
  #     subject.insert_statement(RDF::Statement(:s, RDF.type, :o)) 
  #     subject.insert_statement(RDF::Statement(:s, RDF.type, :q)) 
  #     subject.insert_statement(RDF::Statement(:s, RDF.type, :r))
  #     subject.count
  #     subject.insert_statement(RDF::Statement(:s, RDF::RDFS.label, :q)) 
  #     subject.count
  #     subject.insert_statement(RDF::Statement(:t, RDF::RDFS.label, :q)) 

  #     subject.count

  #     subject.delete_statement(RDF::Statement(:s, RDF.type, :q)) 
  #     subject.delete_statement(RDF::Statement(:s, RDF.type, :o)) 
  #     subject.count
  #     subject.delete_statement(RDF::Statement(:s, RDF.type, :r))
  #     subject.delete_statement(RDF::Statement(:s, RDF::RDFS.label, :q)) 
  #     subject.count
  #     subject.delete_statement(RDF::Statement(:t, RDF::RDFS.label, :q)) 
  #     subject.count
      
  #   end
  # end
end
