require 'spec_helper'
require_relative '../../../../apps/api/views/vendors/index'

describe Api::Views::Vendors::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/api/templates/vendors/index.html.erb') }
  let(:view)      { Api::Views::Vendors::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
