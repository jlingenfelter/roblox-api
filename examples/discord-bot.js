// /songid slash-command handler (discord.js v14)
export async function handleSongId(interaction) {
  const q = interaction.options.getString('search')
  const res = await fetch(`https://rblxdb.com/api/v1/songs?q=${encodeURIComponent(q)}&limit=5`)
  const { songs } = await res.json()
  const lines = songs.map(s => `${s.isWorking ? '🟢' : '⚪'} **${s.name}** — \`${s.id}\``)
  await interaction.reply(lines.join('\n') || `Nothing found for **${q}**`)
}
