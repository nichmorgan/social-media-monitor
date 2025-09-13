# n8n Credentials

This directory contains exported n8n credential definitions.

⚠️ **Security Notice**: This directory may contain sensitive credential exports. Make sure to:

1. Add sensitive credential files to `.gitignore`
2. Use environment variables for sensitive data
3. Never commit actual API keys or passwords

## Best Practices

1. **Environment Variables**: Reference environment variables in credentials
   ```json
   {
     "apiKey": "={{ $env.MY_API_KEY }}"
   }
   ```

2. **Credential Export**: Export credential templates without sensitive data
3. **Team Sharing**: Share credential structures, not actual credentials

## Template Structure

Export credential templates that team members can import and configure with their own credentials.