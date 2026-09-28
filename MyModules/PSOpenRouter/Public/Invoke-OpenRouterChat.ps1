function Invoke-OpenRouterChat {
    <#
    .SYNOPSIS
    Sends a chat request to the OpenRouter API.
    .DESCRIPTION
    Sends a chat request to the OpenRouter API using the specified prompt and model.
    .PARAMETER Prompt
    The prompt to send to the chat model.
    .PARAMETER Model
    The model to use for the chat request. Defaults to "openrouter/auto".
    .PARAMETER ApiKey
    The API key to use for the request. Defaults to the value of the OPENROUTER_API_KEY environment variable.
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string]$Prompt,

        [string]$Model = "openrouter/auto",

        [string]$ApiKey = $env:OPENROUTER_API_KEY
    )

    process {
        $body = @{
            model    = $Model
            messages = @(
                @{
                    role    = "user"
                    content = $Prompt
                }
            )
        } | ConvertTo-Json -Depth 10

        $response = Invoke-RestMethod `
            -Uri "https://openrouter.ai/api/v1/chat/completions" `
            -Method Post `
            -Headers @{
                Authorization = "Bearer $ApiKey"
            } `
            -ContentType "application/json" `
            -Body $body

        $response.choices[0].message.content
    }
}
