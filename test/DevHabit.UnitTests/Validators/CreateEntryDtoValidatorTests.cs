using DevHabit.Api.DTOs.Entries;
using DevHabit.Api.Entities;
using FluentValidation.Results;

namespace DevHabit.UnitTests.Validators;

public sealed class CreateEntryDtoValidatorTests
{
    private readonly CreateEntryDtoValidator _validator = new();

    [Fact]
    public async Task Validate_ShouldSucceed_WhenInputDtoIsValid()
    {
        // Arrange
        var dto = new CreateEntryDto
        {
            HabitId = Habit.NewId(),
            Value = 1,
            Date = DateOnly.FromDateTime(DateTime.UtcNow)
        };

        // Act
        ValidationResult validationResult = await _validator.ValidateAsync(dto);

        // Assert
        Assert.True(validationResult.IsValid);
        Assert.Empty(validationResult.Errors);
    }

    [Fact]
    public async Task Validate_ShouldFail_WhenHabitIdIsEmpty()
    {
        // Arrange
        var dto = new CreateEntryDto
        {
            HabitId = string.Empty,
            Value = 1,
            Date = DateOnly.FromDateTime(DateTime.UtcNow)
        };

        // Act
        ValidationResult validationResult = await _validator.ValidateAsync(dto);

        // Assert
        Assert.False(validationResult.IsValid);
        ValidationFailure validationFailure = Assert.Single(validationResult.Errors);
        Assert.Equal(nameof(CreateEntryDto.HabitId), validationFailure.PropertyName);
    }
}
