class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repo_id)
    repository = Repository.find(repo_id)
    repository.start_fetching!

    begin
      client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
      repo_data = client.repository(Octokit::Repository.from_url(repository.link))

      repository.update!(
        owner_name: repo_data.owner.login,
        repo_name: repo_data.name,
        description: repo_data.description,
        default_branch: repo_data.default_branch,
        watchers_count: repo_data.watchers_count,
        language: repo_data.language,
        repo_created_at: repo_data.created_at,
        repo_updated_at: repo_data.updated_at,
      )
      repository.fetch_success!
    rescue => e
      repository.fetch_fail!
      Rails.logger.error "Failed to fetch repository data: #{e.message}"
    end
  end
end
