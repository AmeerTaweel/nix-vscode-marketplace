# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  ms-python-python = {
    pname = "ms-python-python";
    version = "2022.19.13061131";
    src = fetchurl {
      url = "https://ms-python.gallery.vsassets.io/_apis/public/gallery/publisher/ms-python/extension/python/2022.19.13061131/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "python-2022.19.13061131.zip";
      sha256 = "sha256-BjapzxupoKIyZWGXf5TcLGbiYxBe1ISnoEuBaZz8fpQ=";
    };
    name = "python";
    marketplacePublisher = "ms-python";
    marketplaceName = "python";
    publisher = "ms-python";
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

  ms-toolsai-jupyter = {
    pname = "ms-toolsai-jupyter";
    version = "2022.11.1003082255";
    src = fetchurl {
      url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter/2022.11.1003082255/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "jupyter-2022.11.1003082255.zip";
      sha256 = "sha256-pnGD7ToqqRe9JIsN3G6XkD+NO5A6a6Vsukm1JhCBYzU=";
    };
    name = "jupyter";
    marketplacePublisher = "ms-toolsai";
    marketplaceName = "jupyter";
    publisher = "ms-toolsai";
  };

  ms-python-vscode-pylance = {
    pname = "ms-python-vscode-pylance";
    version = "2022.11.10";
    src = fetchurl {
      url = "https://ms-python.gallery.vsassets.io/_apis/public/gallery/publisher/ms-python/extension/vscode-pylance/2022.11.10/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-pylance-2022.11.10.zip";
      sha256 = "sha256-ieZzyxBpEz4uM/KYjYxAo1D91DAOI+zkTEUjtmNuZaQ=";
    };
    name = "vscode-pylance";
    marketplacePublisher = "ms-python";
    marketplaceName = "vscode-pylance";
    publisher = "ms-python";
  };
}
