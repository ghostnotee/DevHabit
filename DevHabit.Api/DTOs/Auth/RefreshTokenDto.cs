namespace DevHabit.Api.DTOs.Auth;

public record RefreshTokenDto
{
    public required string RefreshToken { get; init; }
}
