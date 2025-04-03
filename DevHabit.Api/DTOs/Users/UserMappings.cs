using DevHabit.Api.DTOs.Auth;
using DevHabit.Api.Entities;

namespace DevHabit.Api.DTOs.Users;

public static class UserMappings
{
    public static User ToEntity(this RegisterUserDto userDto)
    {
        return new User
        {
            Id = $"u_{Guid.CreateVersion7()}",
            Name = userDto.Name,
            Email = userDto.Email,
            CreatedAtUtc = DateTime.UtcNow,
        };
    }
}
