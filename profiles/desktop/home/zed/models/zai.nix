{ ... }:
{
  programs.zed-editor.userSettings.language_models.openai_compatible.zai = {
    api_url = "https://open.bigmodel.cn/api/coding/paas/v4";
    available_models = [
      {
        name = "glm-5.2";
        display_name = "glm-5.2";
        max_tokens = 1000000; # 1M context
        capabilities = {
          tools = true;
          images = false;
          prompt_cache_key = true;
          parallel_tool_calls = false;
        };
      }
    ];
  };
}
