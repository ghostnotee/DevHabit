using DevHabit.Api.Entities;

namespace DevHabit.Api.DTOs.Habits;

public sealed record UpdateHabitDto
{
    public string Name { get; init; }
    public string? Description { get; init; }
    public required HabitType Type { get; init; }
    public FrequencyDto Frequency { get; init; }
    public TargetDto Target { get; init; }
    public DateOnly? EndDate { get; init; }
    public UpdateMilestoneDto? Milestone { get; init; }
    public AutomationSource? AutomationSource { get; init; }
}

public sealed record UpdateMilestoneDto
{
    public required int Target { get; init; }
}
