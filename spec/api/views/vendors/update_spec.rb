require 'spec_helper'
require_relative '../../../../apps/api/views/vendors/update'

describe Api::Views::Vendors::Update do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/api/templates/vendors/update.html.erb') }
  let(:view)      { Api::Views::Vendors::Update.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
