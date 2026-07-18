#include <algorithm>
#include <filesystem>
#include <iostream>
#include <string>
#include <vector>

namespace {
struct BlockDefinition {
    std::string name;
    std::string assetPath;
};

std::vector<BlockDefinition> discoverBlocks(const std::filesystem::path& root) {
    std::vector<BlockDefinition> blocks;
    if (!std::filesystem::exists(root)) {
        return blocks;
    }

    for (const auto& entry : std::filesystem::directory_iterator(root)) {
        if (!entry.is_regular_file()) {
            continue;
        }
        const auto& path = entry.path();
        if (path.extension() != ".png") {
            continue;
        }
        BlockDefinition block;
        block.name = path.stem().string();
        block.assetPath = path.string();
        blocks.push_back(block);
    }

    std::sort(blocks.begin(), blocks.end(), [](const auto& lhs, const auto& rhs) {
        return lhs.name < rhs.name;
    });

    return blocks;
}
}  // namespace

int main() {
    const std::filesystem::path assetsRoot = std::filesystem::path("assets") / "blocks";
    const auto blocks = discoverBlocks(assetsRoot);

    std::cout << "Byte MCPE prototype initialized\n";
    std::cout << "Assets directory: " << assetsRoot.string() << "\n";
    std::cout << "Block count: " << blocks.size() << "\n";

    for (const auto& block : blocks) {
        std::cout << "- " << block.name << " -> " << block.assetPath << "\n";
    }

    return 0;
}
