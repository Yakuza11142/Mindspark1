class LeagueManager {
  static String calculateLeague(int weeklyXp) {
    if (weeklyXp > 5000) return "Diamond 💎";
    if (weeklyXp > 2500) return "Gold 🥇";
    if (weeklyXp > 1000) return "Silver 🥈";
    return "Bronze 🥉";
  }
}