function Invoke-OpenRouterChat {
    <#
    .SYNOPSIS
    Sends a chat request to the OpenRouter API.

    .DESCRIPTION
    Sends a chat request to the OpenRouter API using the specified prompt
    and model.

    .PARAMETER Prompt
    The prompt to send to the chat model.

    .PARAMETER Model
    The model to use for the chat request. Defaults to "openrouter/auto".

    .PARAMETER ApiKey
    The API key to use for the request. Defaults to the value of the
    OPENROUTER_API_KEY environment variable.

    .PARAMETER PassThru
    Returns the complete OpenRouter API response instead of only the
    generated message content.
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string]$Prompt,

        [Parameter(HelpMessage="The model to use for the chat request. Defaults to 'openrouter/free'.")]
        #[ValidateSet("openrouter/free", "openrouter/auto", "nvidia/nemotron-3.5-lightning:free")]
        [string]$Model = "openrouter/free",

        [string]$ApiKey = $env:OPENROUTER_API_KEY,

        [switch]$PassThru
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

        if ($PassThru) {
            $response
        }
        else {
            $response.choices[0].message.content
        }
    }
}
