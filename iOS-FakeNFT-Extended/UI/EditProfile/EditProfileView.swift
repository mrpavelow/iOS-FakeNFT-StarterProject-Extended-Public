import SwiftUI

struct ProfileEditView: View {
    @StateObject private var viewModel: ProfileEditViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: ProfileEditViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            content
                .alert("Ссылка на фото", isPresented: $viewModel.showEditAvatarDialog) {
                    TextField("", text: $viewModel.avatar)
                    Button("Сохранить") {
                        viewModel.showEditAvatarDialog = false
                    }
                    Button("Отмена", role: .cancel) {
                        viewModel.showEditAvatarDialog = false
                    }
                }
                .alert("Уверены, что хотите выйти?", isPresented: $viewModel.showEditAlert) {
                    Button("Остаться", role: .cancel) {
                        
                    }
                    Button("Выйти", role: .destructive) {
                        dismiss()
                    }
                }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if (viewModel.profileIsChanged) {
                        viewModel.showEditAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .failed(let message):
            VStack(spacing: 12) {
                Text(message)
                    .font(.bodyRegular)
                Button("Повторить") {
                    viewModel.saveProfile()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Spacer()
                        ZStack {
                            AsyncImage(url: URL(string: viewModel.profile.avatar)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                            } placeholder: {
                                avatarPlaceholder
                            }
                            Image(systemName: "camera.circle.fill")
                                .font(.headline3)
                                .foregroundStyle(.black, .windowBackground)
                                .offset(x: 26, y: 26)
                        }
                        .onTapGesture {
                            viewModel.showEditAvatarMenu = true
                        }
                        .confirmationDialog("Фото профиля", isPresented: $viewModel.showEditAvatarMenu, titleVisibility: .hidden) {
                            Button("Изменить фото") {
                                viewModel.showEditAvatarMenu = false
                                viewModel.showEditAvatarDialog = true
                            }
                            Button("Удалить фото", role: .destructive) {
                                viewModel.showEditAvatarMenu = false
                            }
                            Button("Отмена", role: .cancel) {
                                viewModel.showEditAvatarMenu = false
                            }
                        }
                        Spacer()
                    }
                    editField(title: "Имя", content: $viewModel.name)
                    editField(title: "Описание", content: $viewModel.description, isEditor: true)
                    editField(title: "Сайт", content: $viewModel.website)
                }
                .offset(y: -8)
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            .background(.white)
            if viewModel.profileIsChanged {
                Button {
                    viewModel.saveProfile()
                } label: {
                    Text("Сохранить")
                        .frame(maxWidth: .infinity, minHeight: 60)
                }
                .font(.bodyBold)
                .foregroundStyle(.white)
                .background(Color(uiColor: .closeButton))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
    }
    
    @ViewBuilder
    private var avatarPlaceholder: some View {
        Image(systemName: "person.crop.circle.fill")
            .background(
                Circle()
                    .frame(width: 70, height: 70)
            )
            .frame(width: 70, height: 70)
    }
    
    @ViewBuilder
    func editField(title: String, content: Binding<String>, isEditor: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.bodyBold)
            if isEditor {
                TextEditor(text: content)
                    .font(.bodyRegular)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 16)
                    .frame(height: 132)
                    .background(Color(uiColor: .fieldBackground))
                    .cornerRadius(12)
            } else {
                TextField("", text: content, axis: .vertical)
                    .font(.bodyRegular)
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(Color(uiColor: .fieldBackground))
                    .cornerRadius(12)
            }
            
        }
    }
}

#Preview {
    ProfileEditView(
        viewModel: ProfileEditViewModel(
            profileService: ProfileServiceStub(profile: MockData.mockProfile), profile: MockData.mockProfile
        )
    )
}
