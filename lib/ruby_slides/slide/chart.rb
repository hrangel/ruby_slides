require 'fileutils'
require 'erb'

module RubySlides
  module Slide
    class Chart
      include RubySlides::Util

      attr_reader :title, :series, :chart_title

      def initialize(options={})
        require_arguments [:title, :series], options
        options.each {|k, v| instance_variable_set("@#{k}", v)}
        series.each do |ser|
          ser[:color] = ("%06x" % (rand * 0xffffff)) if !ser[:color]
        end
      end

      def save(extract_path, index)
        save_rel_xml(extract_path, index)
        save_slide_xml(extract_path, index)
        save_chart_xml(extract_path, index)
      end

      def save_rel_xml(extract_path, index)
        render_view('chart_rel.xml.erb',
                    "#{extract_path}/ppt/slides/_rels/slide#{index}.xml.rels",
                    index: index)
      end
      private :save_rel_xml

      def save_slide_xml(extract_path, index)
        render_view('chart_slide.xml.erb',
                    "#{extract_path}/ppt/slides/slide#{index}.xml")
      end
      private :save_slide_xml

      def save_chart_xml(extract_path, index)
        render_view('chart_ele.xml.erb',
                    "#{extract_path}/ppt/charts/chart#{index}.xml")
      end
    end
  end
end
