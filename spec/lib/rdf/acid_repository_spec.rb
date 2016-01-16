require 'spec_helper'
require 'rdf/spec/repository'

describe RDF::AcidRepository do
  it { expect(subject).to be_a RDF::Repository }
  
  let(:repository) { RDF::AcidRepository.new }
  it_behaves_like 'an RDF::Repository'
end
