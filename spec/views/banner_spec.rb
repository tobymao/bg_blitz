require './spec/spec_helper'

describe Views::Banner do
  it 'should render' do
    view = Views::Banner.new
    expect(view.to_html).not_to be_nil
  end
end
