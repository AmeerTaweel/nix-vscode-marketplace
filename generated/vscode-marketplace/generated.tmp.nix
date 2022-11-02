{mempty = {};

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

  ms-toolsai-jupyter = {
    pname = "ms-toolsai-jupyter";
    version = "2022.11.1003081210";
    src = fetchurl {
      url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter/2022.11.1003081210/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "jupyter-2022.11.1003081210.zip";
      sha256 = "sha256-bsvQguCGdzQ8eyBXz2y4i1cE9A3kneItoR1BjLLcgv4=";
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
