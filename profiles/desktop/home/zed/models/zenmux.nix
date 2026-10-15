# fetch from `models list zenmux --json`
{ ... }:
{
  programs.zed-editor.userSettings.language_models.openai_compatible.zenmux = {
    api_url = "https://zenmux.ai/api/v1";
    available_models = [
      # https://zenmux.ai/openai/gpt-6-luna
      {
        name = "openai/gpt-6-luna";
        display_name = "gpt-6-luna";
        max_tokens = 1100000; # 1.1M context
        capabilities = {
          tools = true;
          images = true;
          prompt_cache_key = false;
          parallel_tool_calls = false;
        };
      }
      # https://zenmux.ai/anthropic/claude-haiku-5.5
      {
        name = "anthropic/claude-haiku-5.5";
        display_name = "claude-haiku-5.5";
        max_tokens = 1000000; # 1M context
        capabilities = {
          tools = true;
          images = true;
          prompt_cache_key = false;
          parallel_tool_calls = false;
        };
      }
      # https://zenmux.ai/deepseek/deepseek-v4-flash
      {
        name = "deepseek/deepseek-v4.1-flash";
        display_name = "deepseek-v4.1-flash";
        max_tokens = 1000000; # 1M context
        capabilities = {
          tools = true;
          images = false;
          prompt_cache_key = false;
          parallel_tool_calls = false;
        };
      }
      # https://zenmux.ai/google/gemini-3.8-flash
      {
        name = "google/gemini-3.8-flash";
        display_name = "gemini-3.8-flash";
        max_tokens = 1000000; # 1M context
        capabilities = {
          tools = true;
          images = true;
          prompt_cache_key = false;
          parallel_tool_calls = false;
        };
      }
    ];
  };
}
