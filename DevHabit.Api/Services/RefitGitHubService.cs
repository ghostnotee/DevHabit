using DevHabit.Api.DTOs.GitHub;
using Refit;

namespace DevHabit.Api.Services;

public sealed class RefitGitHubService(IGithubApi githubApi, ILogger<GitHubService> logger)
{
    public async Task<GitHubUserProfileDto?> GetUserProfileAsync(string accessToken, CancellationToken cancellationToken = default)
    {
        ArgumentException.ThrowIfNullOrEmpty(accessToken);
        ApiResponse<GitHubUserProfileDto> apiResponse = await githubApi.GetUserProfile(accessToken, cancellationToken);
        if (!apiResponse.IsSuccessStatusCode)
        {
            logger.LogWarning("Failed to get Github user profile. Status code: {StatusCode}", apiResponse.StatusCode);
            return null;
        }

        return apiResponse.Content;
    }

    public async Task<IReadOnlyList<GitHubEventDto>?> GetUserEventsAsync(
        string username,
        string accessToken,
        int page = 1,
        int perPage = 100,
        CancellationToken cancellationToken = default)
    {
        ArgumentException.ThrowIfNullOrEmpty(username);
        ArgumentException.ThrowIfNullOrEmpty(username);
        ApiResponse<List<GitHubEventDto>> apiResponse = await githubApi.GetUserEvents(username, accessToken, page, perPage, cancellationToken);
        if (!apiResponse.IsSuccessStatusCode)
        {
            logger.LogWarning("Failed to get Github user events. Status code: {StatusCode}", apiResponse.StatusCode);
            return null;
        }

        return apiResponse.Content;
    }
}
