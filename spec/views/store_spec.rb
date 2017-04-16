require './spec/spec_helper'

describe Views::Store do
  it 'should render' do
    view = Views::Store.new
    expect(view.to_html).not_to be_nil
  end
end
