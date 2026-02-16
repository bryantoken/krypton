module PostsHelper
  def render_embeds(content)
    # Exemplo simples para YouTube
    content.gsub(/(https?:\/\/www\.youtube\.com\/watch\?v=([a-zA-Z0-9_-]+))/) do
      video_id = $2
      content_tag(:div, class: "aspect-video my-4 shadow-[0_0_20px_rgba(34,197,94,0.2)]") do
        content_tag(:iframe, nil, src: "https://www.youtube.com/embed/#{video_id}", class: "w-full h-full rounded-lg border border-green-500/30", allowfullscreen: true)
      end
    end.html_safe
  end
end
