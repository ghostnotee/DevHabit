using DevHabit.Api;
using DevHabit.Api.Extensions;
using DevHabit.Api.Settings;
using Scalar.AspNetCore;

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

app.UseSwagger();
app.UseSwaggerUI();
app.MapScalarApiReference(options =>
{
    options.WithOpenApiRoutePattern("/swagger/1.0/swagger.json");
});

if (app.Environment.IsDevelopment())
{
    /*app.MapOpenApi();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/openapi/v1.json", "DevHabit API V1");
    });*/
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
