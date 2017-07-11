require './spec/spec_helper'

describe Views::Con do
  it 'should render' do
    view = Views::Con.new
    expect(view.to_html).not_to be_nil
  end
end
