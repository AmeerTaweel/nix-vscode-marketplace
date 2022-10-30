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
}
