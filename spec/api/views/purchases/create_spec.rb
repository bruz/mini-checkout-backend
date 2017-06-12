require 'spec_helper'
require_relative '../../../../apps/api/views/purchases/create'

describe Api::Views::Purchases::Create do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/api/templates/purchases/create.html.erb') }
  let(:view)      { Api::Views::Purchases::Create.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
