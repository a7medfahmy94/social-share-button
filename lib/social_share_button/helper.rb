# coding: utf-8
module SocialShareButton
  module Helper
    def social_share_button_tag(title = "", opts = {})
      opts[:allow_sites] ||= SocialShareButton.config.allow_sites

      extra_data = {}
      rel = opts[:rel]
      html = []
      html << "<div class='social-share-button' data-title='#{h title}' data-img='#{opts[:image]}'"
      html << "data-url='#{opts[:url]}' data-desc='#{opts[:desc]}' data-via='#{opts[:via]}'>"

      opts[:allow_sites].each do |name|
        extra_data = opts.select { |k, _| k.to_s.start_with?('data') } if name.eql?('tumblr')
        special_data = opts.select { |k, _| k.to_s.start_with?('data-' + name) }
        klass = "ssb-icon ssb-#{name}"
        if name == 'twitter'
          klass = "ko-twitter knowledge-icon icon-large"
        elsif name == 'email'
          klass = "ko-envelope-o knowledge-icon icon-large"
        elsif name == 'linkedin'
          klass = "fa fa-linkedin knowledge-icon icon-large"
        end
        link_title = t "social_share_button.share_to", :name => t("social_share_button.#{name.downcase}")
        html << link_to("", "#", { :rel => ["nofollow", rel],
                                   "data-site" => name,
                                   :class => klass,
                                   :onclick => "return SocialShareButton.share(this);",
                                   :title => h(link_title) }.merge(extra_data).merge(special_data))
      end
      html << "</div>"
      raw html.join("\n")
    end
  end
end
