using DevHabit.Api;
using DevHabit.Api.Extensions;
using DevHabit.Api.Settings;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder
    .AddApiServices()
    .AddErrorHandling()
    .AddDatabase()
    .AddObservability()
    .AddApplicationServices()
    .AddAuthenticationServices()
    .AddBackgroundJobs()
    .AddCorsPolicy()
    .AddRateLimiting();

WebApplication app = builder.Build();

if (app.Environment.IsDevelopment())
{
    /*app.MapOpenApi();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/openapi/v1.json", "DevHabit API V1");
    });*/
    app.UseSwagger();
    app.UseSwaggerUI();
    await app.ApplyMigrationsAsync();
    await app.SeedInitialDataAsync();
}

app.UseHttpsRedirection();
app.UseExceptionHandler();
app.UseCors(CorsOptions.PolicyName);
app.UseAuthentication();
app.UseAuthorization();
app.UseRateLimiter();
app.UseUserContextEnrichment();
// //app.UseETag();
app.MapControllers();
await app.RunAsync();

// For Integration Tests
public partial class Program;
