require 'spec_helper'
describe 'solr' do
  context 'with defaults for all parameters' do
    it { is_expected.to contain_class('solr') }
  end
end
