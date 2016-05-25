require './spec/spec_helper'

describe Views::Pager do
  it 'should render' do
    view = Views::Pager.new
    expect(view.to_html).not_to be_nil
  end
end
