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
    frequencies = frequencies.sort_by {|a, b| b}
    @frequencies = frequencies.reverse!

    respond_to do |format|
      format.html
      format.json {
        render json: @frequencies
      }
    end
    # puts '*****Pictures*******'
    # p all_tags.count
    # all_tags = all_tags.flatten
    # puts '*****Total Tags*******'
    # p all_tags.count
    # all_tags.delete(query)
    # frequencies = Hash.new(0)
    # all_tags.each { |word| frequencies[word] += 1 }
    # frequencies = frequencies.sort_by {|a, b| b}
    # @frequencies = frequencies.reverse!
  end

  def pages(query, instagram, all_tags)
    if instagram
      tempinst = instagram.pagination.next_max_id
      instagram = Instagram.tag_recent_media(query, :max_id => tempinst ) unless tempinst.nil?
    else
      instagram = Instagram.tag_recent_media(query, {count: 1000})
    end

    instagram.each do |instagram|
      all_tags << instagram.tags
    end

    if tempinst && all_tags.length < 100
      pages(query, instagram, all_tags)
    end

    return all_tags
  end
end
