class Api::StoriesController < ApplicationController

  def index
    stories = StoryFinder.new(scope: policy_scope(Story), params: params).retrieve
      .page(params[:page])
      .per(params[:per])
      .order(created_at: :desc)

    total_pages = stories.total_pages
    stories = Story.where(id: stories.ids)
      .includes(:user, :destinations, :tags)
      .order(created_at: :desc)

    render json: stories, meta: { total_pages: total_pages }
  end

  def show
    story = Story.find(params[:id])

    authorize story

    render json: story
  end

  def create
    skip_authorization

    success, story = CreateStory.build.call(user: current_user, params: story_params)

    if success
      broadcast story

      render json: story,
        status: :created,
        location: [:api, story]
    else
      render json: { errors: story.errors },
        status: :unprocessable_entity
    end
  end

  def update
    story = Story.find(params[:id])

    authorize story

    # need to foce a save even if only the destinations has_many changes. This will force a new paper_trail version for the
    # versions log
    if story.destinations.collect {|d| d.id.to_s}.uniq.sort != story_params[:destination_ids].uniq.sort
      story.updated_at_will_change!
    end

    if story.update(story_params)
      broadcast story
      render json: story,
        status: :ok,
        location: [:api, story]
    else
      render json: { errors: story.errors },
        status: :unprocessable_entity
    end
  end

  def destroy
    story = Story.find(params[:id])

    authorize story

    story.destroy
    broadcast story, :delete

    head :no_content
  end

  private

  def story_params
    params.require(:story).permit(
      :body,
      :embargo_date,
      :headline,
      :is_published,
      destination_ids: [],
      tag_ids: []
    )
  end
end
