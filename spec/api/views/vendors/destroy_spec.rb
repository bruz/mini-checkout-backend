require 'spec_helper'
require_relative '../../../../apps/api/views/vendors/destroy'

describe Api::Views::Vendors::Destroy do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/api/templates/vendors/destroy.html.erb') }
  let(:view)      { Api::Views::Vendors::Destroy.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
