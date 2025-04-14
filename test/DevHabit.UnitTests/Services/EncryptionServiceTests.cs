using System.Security.Cryptography;
using DevHabit.Api.Services;
using DevHabit.Api.Settings;
using Microsoft.Extensions.Options;

namespace DevHabit.UnitTests.Services;

public sealed class EncryptionServiceTests
{
    private readonly EncryptionService _encryptionService;

    public EncryptionServiceTests()
    {
        IOptions<EncryptionOptions> options = Options.Create(new EncryptionOptions
        {
            Key = Convert.ToBase64String(RandomNumberGenerator.GetBytes(32))
        });
        _encryptionService = new EncryptionService(options);
    }

    [Fact]
    public void Decrypt_ShouldReteurnPlainText_WhenDecryptingCorrectCipherText()
    {
        // Arrange
        const string plainText = "sensitive data";
        string cipherText = _encryptionService.Encrypt(plainText);

        // Act
        string decryptedText = _encryptionService.Decrypt(cipherText);

        // Assert
        Assert.Equal(plainText, decryptedText);
    }
}
