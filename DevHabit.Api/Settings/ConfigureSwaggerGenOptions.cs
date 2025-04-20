using System.Reflection;
using Asp.Versioning.ApiExplorer;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace DevHabit.Api.Settings;

public sealed class ConfigureSwaggerGenOptions(IApiVersionDescriptionProvider apiVersionDescriptionProvider) : IConfigureNamedOptions<SwaggerGenOptions>
{
    public void Configure(SwaggerGenOptions options)
    {
        foreach (ApiVersionDescription apiVersionDescription in apiVersionDescriptionProvider.ApiVersionDescriptions)
        {
            var openApiInfo = new OpenApiInfo
            {
                Title = $"DevHabit.Api v{apiVersionDescription.ApiVersion}",
                Version = apiVersionDescription.ApiVersion.ToString()
            };
            options.SwaggerDoc(apiVersionDescription.GroupName, openApiInfo);
        }

        options.ResolveConflictingActions(apiDescriptions => apiDescriptions.First());
        string xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
        string xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
        options.IncludeXmlComments(xmlPath);
        options.CustomSchemaIds(type => type.FullName?.Replace("+", "."));
        options.DescribeAllParametersInCamelCase();

        options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
        {
            Description =
                "JWT Authorization header using the Bearer scheme. \r\n\r\n Enter 'Bearer' [space] and then your token in the text input below.\r\n\r\nExample: \"Bearer 12345abcdef\"",
            Name = "Authorization",
            In = ParameterLocation.Header,
            Type = SecuritySchemeType.ApiKey,
            Scheme = JwtBearerDefaults.AuthenticationScheme
        });

        options.AddSecurityRequirement(new OpenApiSecurityRequirement
        {
            {
                new OpenApiSecurityScheme
                {
                    Reference = new OpenApiReference
                    {
                        Type = ReferenceType.SecurityScheme,
                        Id = JwtBearerDefaults.AuthenticationScheme
                    }
                },
                Array.Empty<string>()
            }
        });
    }

    public void Configure(string? name, SwaggerGenOptions options)
    {
        Configure(options);
    }
}
