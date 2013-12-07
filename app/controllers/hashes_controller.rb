class HashesController < ApplicationController

  def index
    all_tags = []
    query = params[:search]
    instagram = nil
    if query
      pages(query, instagram, all_tags)
    end
    all_tags = all_tags.flatten
    all_tags.delete(query)

    frequencies = Hash.new(0)
    all_tags.each { |word| frequencies[word] += 1 }
    frequencies = frequencies.delete_if {|a, b| b <= 1}
    frequencies = frequencies.sort_by {|a, b| b}
    @frequencies = frequencies.reverse!

    chart_freq = frequencies.first(5)
    @chart_data = []
    chart_freq.each do |a, b|
      @chart_data << {keyword: a, value: b}
    end
    puts "**********"
    p @chart_data
    respond_to do |format|
      format.html
      format.json {
        render json: {
          frequencies: @frequencies,
          chart: @chart_data
        }
      }
    end
  end

  def pages(query, instagram, all_tags)
    if instagram
      tempinst = instagram.pagination.next_max_id
      instagram = Instagram.tag_recent_media(query, :max_id => tempinst ) unless tempinst.nil?
    else
      instagram = Instagram.tag_recent_media(query, {count: 1000})
    end

    instagram.each do |instagram|
      if instagram.tags.length >= 1
        all_tags << instagram.tags
      end
    end

    if all_tags.length < 50
      pages(query, instagram, all_tags)
    end
    return all_tags
  end
end
