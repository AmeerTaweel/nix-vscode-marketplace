{mempty = {};

  ms-python-python = {
    pname = "ms-python-python";
    version = "2022.17.13020517";
    src = fetchurl {
      url = "https://ms-python.gallery.vsassets.io/_apis/public/gallery/publisher/ms-python/extension/python/2022.17.13020517/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "python-2022.17.13020517.zip";
      sha256 = "sha256-JrIPtFgMgi+kd2svECUAiYEpnA+bBM1j2XXd5z0m8Hk=";
    };
    name = "python";
    marketplacePublisher = "ms-python";
    marketplaceName = "python";
    publisher = "ms-python";
  };
  ms-python-vscode-pylance = {
    pname = "ms-python-vscode-pylance";
    version = "2022.10.41";
    src = fetchurl {
      url = "https://ms-python.gallery.vsassets.io/_apis/public/gallery/publisher/ms-python/extension/vscode-pylance/2022.10.41/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-pylance-2022.10.41.zip";
      sha256 = "sha256-pUXdWfxQeKp+zLras8+NToLDekW+HFjnk/Qw5/LzCc0=";
    };
    name = "vscode-pylance";
    marketplacePublisher = "ms-python";
    marketplaceName = "vscode-pylance";
    publisher = "ms-python";
  };
  ms-toolsai-jupyter = {
    pname = "ms-toolsai-jupyter";
    version = "2022.10.1103032004";
    src = fetchurl {
      url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter/2022.10.1103032004/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "jupyter-2022.10.1103032004.zip";
      sha256 = "sha256-O/8rW1sXluq1zto1JIuMNsDBsvjvjKj+RvC4XlRiZ/w=";
    };
    name = "jupyter";
    marketplacePublisher = "ms-toolsai";
    marketplaceName = "jupyter";
    publisher = "ms-toolsai";
  };
<<<<<<< Updated upstream
=======

  ms-toolsai-jupyter-keymap = {
    pname = "ms-toolsai-jupyter-keymap";
    version = "1.0.0";
    src = fetchurl {
      url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter-keymap/1.0.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "jupyter-keymap-1.0.0.zip";
      sha256 = "sha256-aP9mRvNfJ/fXSZk286FPo9gH80qwqm8mTDQ2BR+lfHI=";
    };
    name = "jupyter-keymap";
    marketplacePublisher = "ms-toolsai";
    marketplaceName = "jupyter-keymap";
    publisher = "ms-toolsai";
  };
  ms-toolsai-jupyter-renderers = {
    pname = "ms-toolsai-jupyter-renderers";
    version = "1.0.12";
    src = fetchurl {
      url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter-renderers/1.0.12/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "jupyter-renderers-1.0.12.zip";
      sha256 = "sha256-HziacDGDg5HBMWkaO/v4/jdMuFFmMkTP6Xb8O4H5hYo=";
    };
    name = "jupyter-renderers";
    marketplacePublisher = "ms-toolsai";
    marketplaceName = "jupyter-renderers";
    publisher = "ms-toolsai";
  };
  ms-vscode-cpptools = {
    pname = "ms-vscode-cpptools";
    version = "1.13.3";
    src = fetchurl {
      url = "https://ms-vscode.gallery.vsassets.io/_apis/public/gallery/publisher/ms-vscode/extension/cpptools/1.13.3/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "cpptools-1.13.3.zip";
      sha256 = "sha256-BxBOFlkRrk+QOba5BaNiRnkfJlHMMU61bBC6g4WcZmQ=";
    };
    name = "cpptools";
    marketplacePublisher = "ms-vscode";
    marketplaceName = "cpptools";
    publisher = "ms-vscode";
  };
  VisualStudioExptTeam-vscodeintellicode = {
    pname = "VisualStudioExptTeam-vscodeintellicode";
    version = "1.2.29";
    src = fetchurl {
      url = "https://VisualStudioExptTeam.gallery.vsassets.io/_apis/public/gallery/publisher/VisualStudioExptTeam/extension/vscodeintellicode/1.2.29/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscodeintellicode-1.2.29.zip";
      sha256 = "sha256-Wl++d7mCOjgL7vmVVAKPQQgWRSFlqL4ry7v0wob1OyU=";
    };
    name = "vscodeintellicode";
    marketplacePublisher = "VisualStudioExptTeam";
    marketplaceName = "vscodeintellicode";
    publisher = "visualstudioexptteam";
  };
  esbenp-prettier-vscode = {
    pname = "esbenp-prettier-vscode";
    version = "9.9.0";
    src = fetchurl {
      url = "https://esbenp.gallery.vsassets.io/_apis/public/gallery/publisher/esbenp/extension/prettier-vscode/9.9.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "prettier-vscode-9.9.0.zip";
      sha256 = "sha256-Yr7M4HyRNcsBf8YglQLvyZjblMhtkpMP+f9SH8oUav0=";
    };
    name = "prettier-vscode";
    marketplacePublisher = "esbenp";
    marketplaceName = "prettier-vscode";
    publisher = "esbenp";
  };
  ritwickdey-LiveServer = {
    pname = "ritwickdey-LiveServer";
    version = "5.7.9";
    src = fetchurl {
      url = "https://ritwickdey.gallery.vsassets.io/_apis/public/gallery/publisher/ritwickdey/extension/LiveServer/5.7.9/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "LiveServer-5.7.9.zip";
      sha256 = "sha256-w0CYSEOdltwMFzm5ZhOxSrxqQ1y4+gLfB8L+EFFgzDc=";
    };
    name = "liveserver";
    marketplacePublisher = "ritwickdey";
    marketplaceName = "LiveServer";
    publisher = "ritwickdey";
  };
  MS-CEINTL-vscode-language-pack-zh-hans = {
    pname = "MS-CEINTL-vscode-language-pack-zh-hans";
    version = "1.73.10191020";
    src = fetchurl {
      url = "https://MS-CEINTL.gallery.vsassets.io/_apis/public/gallery/publisher/MS-CEINTL/extension/vscode-language-pack-zh-hans/1.73.10191020/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-language-pack-zh-hans-1.73.10191020.zip";
      sha256 = "sha256-8Y3ZocdagDxs+2UM1+sksv64+kInNc28Z6vu4ExzK5g=";
    };
    name = "vscode-language-pack-zh-hans";
    marketplacePublisher = "MS-CEINTL";
    marketplaceName = "vscode-language-pack-zh-hans";
    publisher = "ms-ceintl";
  };
  dbaeumer-vscode-eslint = {
    pname = "dbaeumer-vscode-eslint";
    version = "2.2.6";
    src = fetchurl {
      url = "https://dbaeumer.gallery.vsassets.io/_apis/public/gallery/publisher/dbaeumer/extension/vscode-eslint/2.2.6/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-eslint-2.2.6.zip";
      sha256 = "sha256-1yZeyLrXuubhKzobWcd00F/CdU824uJDTkB6qlHkJlQ=";
    };
    name = "vscode-eslint";
    marketplacePublisher = "dbaeumer";
    marketplaceName = "vscode-eslint";
    publisher = "dbaeumer";
  };
  redhat-java = {
    pname = "redhat-java";
    version = "1.12.2022102604";
    src = fetchurl {
      url = "https://redhat.gallery.vsassets.io/_apis/public/gallery/publisher/redhat/extension/java/1.12.2022102604/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "java-1.12.2022102604.zip";
      sha256 = "sha256-3q9iJGD9mTQEg4wqDkXLOz0XLQ4skcjoIs8acF29PKQ=";
    };
    name = "java";
    marketplacePublisher = "redhat";
    marketplaceName = "java";
    publisher = "redhat";
  };
  eamodio-gitlens = {
    pname = "eamodio-gitlens";
    version = "2022.10.2605";
    src = fetchurl {
      url = "https://eamodio.gallery.vsassets.io/_apis/public/gallery/publisher/eamodio/extension/gitlens/2022.10.2605/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "gitlens-2022.10.2605.zip";
      sha256 = "sha256-DZAw7FtzwwJZQAErFKAd9whtp/Bsq76gbaZ9EHja588=";
    };
    name = "gitlens";
    marketplacePublisher = "eamodio";
    marketplaceName = "gitlens";
    publisher = "eamodio";
  };
  ms-azuretools-vscode-docker = {
    pname = "ms-azuretools-vscode-docker";
    version = "1.22.2";
    src = fetchurl {
      url = "https://ms-azuretools.gallery.vsassets.io/_apis/public/gallery/publisher/ms-azuretools/extension/vscode-docker/1.22.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-docker-1.22.2.zip";
      sha256 = "sha256-sRvd9M/gF4kh4qWxtS1xKKIvqg9hRJpRl/p/FYu2TI8=";
    };
    name = "vscode-docker";
    marketplacePublisher = "ms-azuretools";
    marketplaceName = "vscode-docker";
    publisher = "ms-azuretools";
  };
  ms-dotnettools-csharp = {
    pname = "ms-dotnettools-csharp";
    version = "1.25.0";
    src = fetchurl {
      url = "https://ms-dotnettools.gallery.vsassets.io/_apis/public/gallery/publisher/ms-dotnettools/extension/csharp/1.25.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "csharp-1.25.0.zip";
      sha256 = "sha256-WE4DbJr1HqoyuS3mVYmIgd9DDTuSKPd6vdZn4YOPUtU=";
    };
    name = "csharp";
    marketplacePublisher = "ms-dotnettools";
    marketplaceName = "csharp";
    publisher = "ms-dotnettools";
  };

  ms-toolsai-jupyter-keymap = {
    pname = "ms-toolsai-jupyter-keymap";
    version = "1.0.0";
    src = fetchurl {
      url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter-keymap/1.0.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "jupyter-keymap-1.0.0.zip";
      sha256 = "sha256-aP9mRvNfJ/fXSZk286FPo9gH80qwqm8mTDQ2BR+lfHI=";
    };
    name = "jupyter-keymap";
    marketplacePublisher = "ms-toolsai";
    marketplaceName = "jupyter-keymap";
    publisher = "ms-toolsai";
  };
  ms-toolsai-jupyter-renderers = {
    pname = "ms-toolsai-jupyter-renderers";
    version = "1.0.12";
    src = fetchurl {
      url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter-renderers/1.0.12/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "jupyter-renderers-1.0.12.zip";
      sha256 = "sha256-HziacDGDg5HBMWkaO/v4/jdMuFFmMkTP6Xb8O4H5hYo=";
    };
    name = "jupyter-renderers";
    marketplacePublisher = "ms-toolsai";
    marketplaceName = "jupyter-renderers";
    publisher = "ms-toolsai";
  };
  ms-vscode-cpptools = {
    pname = "ms-vscode-cpptools";
    version = "1.13.3";
    src = fetchurl {
      url = "https://ms-vscode.gallery.vsassets.io/_apis/public/gallery/publisher/ms-vscode/extension/cpptools/1.13.3/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "cpptools-1.13.3.zip";
      sha256 = "sha256-BxBOFlkRrk+QOba5BaNiRnkfJlHMMU61bBC6g4WcZmQ=";
    };
    name = "cpptools";
    marketplacePublisher = "ms-vscode";
    marketplaceName = "cpptools";
    publisher = "ms-vscode";
  };
>>>>>>> Stashed changes
}
