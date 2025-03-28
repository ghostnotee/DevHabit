namespace DevHabit.Api.DTOs.Common;

public interface ICollectionResponse<T>
{
    List<T> Items { get; init; }
}

public interface ILinksResponse
{
    List<LinkDto> Links { get; set; }
}
