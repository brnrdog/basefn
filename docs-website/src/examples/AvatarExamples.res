open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Avatar Sizes",
    description: "User avatars in different sizes.",
    demo: <div style="display: flex; gap: 1rem; align-items: center;">
      <Avatar name="John Doe" size={Avatar.Sm} src="https://i.pravatar.cc" />
      <Avatar name="Jane Smith" size={Avatar.Md} src="https://i.pravatar.cc" />
      <Avatar name="Bob Johnson" size={Avatar.Lg} src="https://i.pravatar.cc" />
    </div>,
    code: `<Avatar name="John Doe" size={Avatar.Sm} />
<Avatar name="Jane Smith" size={Avatar.Md} />`,
  },
  {
    title: "Avatar with Image",
    description: "Avatar displaying profile images.",
    demo: <div style="display: flex; gap: 1rem;">
      <Avatar src="https://i.pravatar.cc" name="User 1" />
      <Avatar src="https://i.pravatar.cc" name="User 2" />
      <Avatar src="https://i.pravatar.cc" name="User 3" />
    </div>,
    code: `<Avatar src="https://i.pravatar.cc" name="User 1" />`,
  },
]
