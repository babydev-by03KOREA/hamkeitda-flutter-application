enum HelpLevel { independent, partial, dependent }

String helpLevelToLabel(HelpLevel level) {
  switch (level) {
    case HelpLevel.independent:
      return 'X'; // 완전 자립
    case HelpLevel.partial:
      return '△'; // 부분 도움
    case HelpLevel.dependent:
      return '○'; // 완전 도움
  }
}
