require './spec/spec_helper'

describe Views::PodcastRSS do
  let(:data) { { posts: [], items: [] } }

  it 'should render' do
    expect(Views::PodcastRSS.rss data).not_to be_nil
  end
end
