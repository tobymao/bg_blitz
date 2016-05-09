require './spec/spec_helper'

describe Views::Audio do
  let(:file) { double 'File', url: '', mime_type: '' }

  it 'should render' do
    view = Views::Audio.new file: file
    expect(view.to_html).not_to be_nil
  end
end
