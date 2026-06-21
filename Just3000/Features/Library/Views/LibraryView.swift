import SwiftUI

struct LibraryView: View {
    @Binding var path: NavigationPath
    @State private var viewModel = LibraryViewModel()
    @State private var searchText = ""
    @State private var filter: LibraryFilter = .all
    @State private var sort: LibrarySort = .byRank
    @State private var selectedWord: LibraryWord?

    private var words: [LibraryWord] {
        viewModel.filtered(search: searchText, filter: filter, sort: sort)
    }

    private var isSearching: Bool {
        !searchText.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        VStack {
            PageHeader(
                title: "Library",
                subtitle: "3,000 words · \(viewModel.masteredCount) mastered",
                trailing: {}
            )
            
            LibrarySearchBar(text: $searchText)
            
            ScrollView {
                VStack(spacing: 0) {
                    if isSearching {
                        HStack {
                            Text("\(words.count) result\(words.count != 1 ? "s" : "")")
                                .font(.system(size: 13))
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    } else {
                        VStack(spacing: 12) {
                            SegmentedControl(
                                selection: $filter,
                                items: LibraryFilter.allCases,
                                label: { $0.rawValue }
                            )
                            HStack(spacing: 8) {
                                SortChip(label: "By Rank", isOn: sort == .byRank)      { sort = .byRank }
                                SortChip(label: "A–Z",     isOn: sort == .alphabetical) { sort = .alphabetical }
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }

                    WordList(words: words) { selectedWord = $0 }
                        .padding(.horizontal, 16)
                        .padding(.top, 6)
                        .padding(.bottom, 32)
                }
            }
            .sheet(item: $selectedWord) { word in
                WordDetailSheet(word: word)
            }
        }
        .dotGridBackground()
    }
}

#Preview {
    NavigationStack {
        LibraryView(path: .constant(NavigationPath()))
    }
}
