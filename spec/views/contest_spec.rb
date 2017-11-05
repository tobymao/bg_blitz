require './spec/spec_helper'

describe Views::Contest do
  it 'should render' do
    view = Views::Contest.new
    expect(view.to_html).not_to be_nil
  end
end
