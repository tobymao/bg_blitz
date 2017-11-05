require './views/page'

module Views
  class Contest < Page
    def render_main
      div style: default_container_style do
        iframe(
          src: 'https://docs.google.com/forms/d/e/1FAIpQLSdaIT7OcIMeUT4vvn0mzJJL6IE9_8_q65obznxRlrzT35Hx3g/viewform?embedded=true',
          width: '100%',
          height: '100%',
          frameborder: 0,
          marginheight: 0,
          marginwidth: 0,
        ) { text 'Loading...' }
      end
    end

    def page_title
      'Contest'
    end

  end
end
