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
  {
    title: "Fallback",
    description: "When no image is provided, the avatar shows initials from the name or a default icon.",
    demo: <div style="display: flex; gap: 1rem; align-items: center;">
      <Avatar name="Alice Brown" size={Avatar.Sm} />
      <Avatar name="Bob Carter" size={Avatar.Md} />
      <Avatar name="Charlie Davis" size={Avatar.Lg} />
      <Avatar size={Avatar.Md} />
    </div>,
    code: `// Shows initials "AB"
<Avatar name="Alice Brown" />

// Shows initials "BC"
<Avatar name="Bob Carter" />

// Shows default User icon
<Avatar />`,
  },
]
