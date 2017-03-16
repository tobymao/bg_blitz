require './spec/spec_helper'

describe Views::Support do
  it 'should render' do
    view = Views::Support.new
    expect(view.to_html).not_to be_nil
  end
end
