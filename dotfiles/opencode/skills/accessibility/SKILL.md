# Accessibility in End-User Applications

> When you develop web or mobile applications that face end users, you are building objects that alter people's lives — for better or worse. Accessibility is not a feature; it is the foundation of ethical design.

This skill draws from Alan Dalton's article *Good Designers, Bad Websites: A Proposal* (A List Apart, 2026) and the resources linked within it. Use these principles, personas, and checklists to recognize accessibility issues during development, not after.

---

## Why This Matters

Even a straightforward bus timetable app can affect life and death events:
- Somebody might miss a life event (a daughter's birthday party).
- Somebody might miss a death event (the chance to say goodbye to a dying grandmother).

Objects have value not because of what they are, but because of what they enable us to do. As the people who make these objects, we have a profound responsibility.

**Source:** [Good designers, bad websites: a proposal](https://alistapart.com/article/good-designers-bad-websites-a-proposal/) by Alan Dalton, A List Apart; inspired by [This Is All There Is](http://www.breakingthin.gs/this-is-all-there-is.html) by Aral Balkan.

---

## Jakob Nielsen's 10 Usability Heuristics

These heuristics, originally developed by Jakob Nielsen and Rolf Molich in 1990 and refined in 1994, have remained relevant and unchanged for over 30 years. When something has remained true for that long, it will likely apply to future generations of user interfaces as well.

**Source:** [10 Usability Heuristics for User Interface Design](https://www.nngroup.com/articles/ten-usability-heuristics/) by Jakob Nielsen, Nielsen Norman Group.

---

### 1. Visibility of System Status

> The design should always keep users informed about what is going on, through appropriate feedback within a reasonable amount of time.

When users know the current system status, they learn the outcome of their prior interactions and determine next steps. Predictable interactions create trust in the product as well as the brand.

**Tips:**
- Communicate clearly to users what the system's state is — no action with consequences to users should be taken without informing them.
- Present feedback to the user as quickly as possible (ideally, immediately).
- Build trust through open and continuous communication.

**Example:** "You Are Here" indicators on mall maps show people where they currently are, to help them understand where to go next.

**Learn more:**
- [Visibility of System Status (Usability Heuristic #1)](https://www.nngroup.com/articles/visibility-system-status/)
- [Video: Visibility Heuristic](https://www.nngroup.com/videos/usability-heuristic-system-status/)

---

### 2. Match Between the System and the Real World

> The design should speak the users' language. Use words, phrases, and concepts familiar to the user, rather than internal jargon. Follow real-world conventions, making information appear in a natural and logical order.

Terms, concepts, icons, and images that seem perfectly clear to you and your colleagues may be unfamiliar or confusing to your users. When controls follow real-world conventions (natural mapping), it's easier for users to learn and remember how the interface works.

**Tips:**
- Ensure that users can understand meaning without having to look up a word's definition.
- Never assume your understanding of words or concepts will match that of your users.
- User research will uncover your users' familiar terminology, as well as their mental models around important concepts.

**Example:** When stovetop controls match the layout of heating elements, users can quickly understand which control maps to which heating element.

**Learn more:**
- [Match Between the System and the Real World](https://www.nngroup.com/articles/match-system-real-world/)
- [Video: Match Between the System and the Real World](https://www.nngroup.com/videos/match-system-real-world/)

---

### 3. User Control and Freedom

> Users often perform actions by mistake. They need a clearly marked "emergency exit" to leave the unwanted action without having to go through an extended process.

When it's easy for people to back out of a process or undo an action, it fosters a sense of freedom and confidence. Exits allow users to remain in control of the system and avoid getting stuck and feeling frustrated.

**Tips:**
- Support Undo and Redo.
- Show a clear way to exit the current interaction, like a Cancel button.
- Make sure the exit is clearly labeled and discoverable.

**Example:** Digital spaces need quick emergency exits, just like physical spaces do.

**Learn more:**
- [User Control and Freedom](https://www.nngroup.com/articles/user-control-and-freedom/)
- [Video: User Control and Freedom](https://www.nngroup.com/videos/usability-heuristic-user-control-freedom/)

---

### 4. Consistency and Standards

> Users should not have to wonder whether different words, situations, or actions mean the same thing. Follow platform and industry conventions.

Jakob's Law states that people spend most of their time using digital products *other than yours*. Users' experiences with those other products set their expectations. Failing to maintain consistency may increase cognitive load by forcing them to learn something new.

**Tips:**
- Improve learnability by maintaining both internal consistency (within your product) and external consistency (industry/platform conventions).
- Maintain consistency within a single product or a family of products.
- Follow established industry conventions.

**Example:** Check-in counters are usually located at the front of hotels. This consistency meets customers' expectations.

**Learn more:**
- [Consistency and Standards](https://www.nngroup.com/articles/consistency-and-standards/)
- [Video: Consistency and Standards](https://www.nngroup.com/videos/usability-heuristic-consistency-standards/)

---

### 5. Error Prevention

> Good error messages are important, but the best designs carefully prevent problems from occurring in the first place. Either eliminate error-prone conditions, or check for them and present users with a confirmation option before they commit to the action.

There are two types of errors: slips (unconscious errors caused by inattention) and mistakes (conscious errors based on a mismatch between the user's mental model and the design).

**Tips:**
- Prioritize your effort: Prevent high-cost errors first, then little frustrations.
- Avoid slips by providing helpful constraints and good defaults.
- Prevent mistakes by removing memory burdens, supporting undo, and warning your users.

**Example:** Guard rails on curvy mountain roads prevent drivers from falling off cliffs.

**Learn more:**
- [Preventing User Errors](https://www.nngroup.com/articles/slips/)
- [Video: Error Prevention](https://www.nngroup.com/videos/usability-heuristic-error-prevention/)

---

### 6. Recognition Rather Than Recall

> Minimize the user's memory load by making elements, actions, and options visible. The user should not have to remember information from one part of the interface to another. Information required to use the design should be visible or easily retrievable when needed.

Humans have limited short-term memory. Interfaces that promote recognition reduce the amount of cognitive effort required from users.

**Adapt this for your team:** The information required to *produce* accessible design should also be visible or easily retrievable when needed. Don't expect developers and designers to memorize every guideline. Make it easy to recognize issues while you work.

**Tips:**
- Let people recognize information in the interface, rather than forcing them to remember ("recall") it.
- Offer help in context, instead of giving users a long tutorial to memorize.
- Reduce the information that users have to remember.

**Example:** It's easier for most people to recognize the capitals of countries than to remember them. People are more likely to correctly answer *Is Lisbon the capital of Portugal?* rather than *What's the capital of Portugal?*

**Learn more:**
- [Recognition vs. Recall in UX](https://www.nngroup.com/articles/recognition-and-recall/)
- [Video: Recognition vs. Recall](https://www.nngroup.com/videos/recognition-vs-recall/)

---

### 7. Flexibility and Efficiency of Use

> Shortcuts — hidden from novice users — may speed up the interaction for the expert user so that the design can cater to both inexperienced and experienced users. Allow users to tailor frequent actions.

Flexible processes can be carried out in different ways, so that people can pick whichever method works for them.

**Tips:**
- Provide accelerators like keyboard shortcuts and touch gestures.
- Provide personalization by tailoring content and functionality for individual users.
- Allow for customization, so users can make selections about how they want the product to work.

**Example:** Regular routes are listed on maps, but locals with knowledge of the area can take shortcuts.

**Learn more:**
- [Flexibility and Efficiency of Use](https://www.nngroup.com/articles/flexibility-efficiency-heuristic/)
- [Video: Flexibility and Efficiency of Use](https://www.nngroup.com/videos/flexibility-efficiency-use/)

---

### 8. Aesthetic and Minimalist Design

> Interfaces should not contain information that is irrelevant or rarely needed. Every extra unit of information in an interface competes with the relevant units of information and diminishes their relative visibility.

This heuristic doesn't mean you have to use flat design — it's about keeping content and visual design focused on the essentials. Ensure that visual elements support the user's primary goals.

**Tips:**
- Keep the content and visual design of UI focused on the essentials.
- Don't let unnecessary elements distract users from the information they really need.
- Prioritize the content and features to support primary goals.

**Example:** An ornate teapot may have excessive decorative elements, like an uncomfortable handle or hard-to-wash nozzle, that can interfere with usability.

**Learn more:**
- [Aesthetic and Minimalist Design](https://www.nngroup.com/articles/aesthetic-minimalist-design/)
- [Video: Aesthetic and Minimalist Design](https://www.nngroup.com/videos/aesthetic-and-minimalist-design/)

---

### 9. Help Users Recognize, Diagnose, and Recover from Errors

> Error messages should be expressed in plain language (no error codes), precisely indicate the problem, and constructively suggest a solution.

These error messages should also be presented with visual treatments that will help users notice and recognize them.

**Tips:**
- Use traditional error-message visuals, like bold, red text.
- Tell users what went wrong in language they will understand — avoid technical jargon.
- Offer users a solution, like a shortcut that can solve the error immediately.

**Example:** Wrong way signs on the road remind drivers that they are heading in the wrong direction and ask them to stop.

**Learn more:**
- [Error-Message Guidelines](https://www.nngroup.com/articles/error-message-guidelines/)
- [Video: Helping Users Overcome Errors](https://www.nngroup.com/videos/usability-heuristic-recognize-errors/)

---

### 10. Help and Documentation

> It's best if the system doesn't need any additional explanation. However, it may be necessary to provide documentation to help users understand how to complete their tasks.

Help and documentation content should be easy to search and focused on the user's task. Keep it concise, and list concrete steps that need to be carried out.

**Tips:**
- Ensure that the help documentation is easy to search.
- Whenever possible, present the documentation in context right at the moment that the user requires it.
- List concrete steps to be carried out.

**Example:** Information kiosks at airports are easily recognizable and solve customers' problems in context and immediately.

**Learn more:**
- [Help and Documentation](https://www.nngroup.com/articles/help-and-documentation/)
- [Video: Help and Documentation](https://www.nngroup.com/videos/help-and-documentation/)

---

## Meet Your Users: Accessibility Personas

The following personas are from *A Web for Everyone* by Sarah Horton and Whitney Quesenbery (Rosenfeld Media, 2014). For each project, ask: *"Will this work for Vishnu? How will Trevor experience this?"*

### Vishnu — Engineer with low vision
- Uses screen magnification, high-contrast mode, and personalized stylesheets
- Needs text that can be resized without breaking layouts
- Appreciates clear language (English is his third language)
- **Design for:** zoom compatibility, flexible layouts, plain language
**Source:** [Vishnu: Engineer, global citizen with low vision](https://knowaboutaccessibility.org/2025/05/08/vishnu-engineer-global-citizen-with-low-vision/)

### Trevor — High school student with autism
- Loves consistency and familiar patterns
- Gets distracted by moving images, ads, and too many choices
- Reads every word literally; struggles with metaphors and colloquialisms
- **Design for:** predictable navigation, reduced motion, clear labels, distraction-free reading modes
**Source:** [Trevor: High school student with autism](https://knowaboutaccessibility.org/2025/05/08/trevor-high-school-student-with-autism/)

### Steven — Deaf graphic artist and ASL speaker
- Native language is American Sign Language; reads English as a second language
- Video without captions is meaningless
- Prefers visual information over text walls
- **Design for:** captions/transcripts for all audio/video, visual alternatives, clear spelling (affects search)
**Source:** [Steven: Deaf graphic artist and ASL speaker](https://knowaboutaccessibility.org/2025/05/08/steven-deaf-graphic-artist-and-asl-speaker/)

### Maria — Bilingual community health worker
- Prefers to read in Spanish, especially for professional health information
- Finds confusing sites overwhelming; leaves when there are too many decisions
- Appreciates captions on videos — helps her learn scientific spelling while hearing the words
- **Design for:** clear site purpose, simple layouts, multilingual support, good captions
**Source:** [Maria: Bilingual community health worker](https://knowaboutaccessibility.org/2025/04/28/maria-bilingual-community-health-worker/)

### Lea — Editor living with fatigue and pain
- Uses a split keyboard, trackball, and Dragon Naturally Speaking speech recognition
- Navigates almost exclusively by keyboard — a mouse is too physically demanding
- Appreciates skip links and table of contents on long pages
- **Design for:** full keyboard navigation, skip links, logical heading structure, minimal physical effort
**Source:** [Lea: Editor, living with fatigue and pain](https://knowaboutaccessibility.org/2025/04/28/lea-editor-living-with-fatigue-and-pain/)

### Jacob — Blind paralegal
- Uses screen readers (JAWS on laptop, VoiceOver on phone) and a braille display
- Previews content by jumping between headings
- Forms without proper labels are unusable
- **Design for:** semantic HTML, logical heading hierarchy, labeled form fields, keyboard navigation, ARIA where needed
**Source:** [Jacob: Blind paralegal and a bit of a geek](https://knowaboutaccessibility.org/2025/04/28/jacob-blind-paralegal-and-a-bit-of-a-geek/)

### Emily — Cerebral palsy, living independently
- Uses a motorized wheelchair and an iPad mounted on her scooter
- Limited finger dexterity; touch targets must be large and well-spaced
- Needs to know all required documents *before* starting a process
- **Design for:** large touch targets (minimum 44x44pt), simple screens, advance disclosure of requirements
**Source:** [Emily: Cerebral palsy, living independently](https://knowaboutaccessibility.org/2025/04/28/emily-cerebral-palsy-living-independently/)

### Carol — Grandmother with macular degeneration
- Enlarges text in her browser; frustrated when sites don't respond
- Unsteady hands; mis-clicks small buttons
- Confused by unclear error messages and light gray text on white
- **Design for:** text resizing support, high contrast, large buttons, clear error messages
**Source:** [Carol: Grandmother with macular degeneration](https://knowaboutaccessibility.org/2025/04/21/carol-grandmother-with-macular-degeneration/)

**All personas:** [Know About Accessibility — Personas](https://knowaboutaccessibility.org/tag/personas/)

---

## Team Practices

### The Designated Dissenter
On every project, assign one person the explicit job of questioning assumptions and finding failure states. Their duty is to ask:
- "What if the user is in a crisis?"
- "Could this copy be alienating?"
- "What assumptions are we making about the user's context?"

Rotate this role per project so the whole team develops the skill.

**Source:** [Design for Real Life](https://dfrlbook.com/) by Eric Meyer and Sara Wachter-Boettcher; [Chapter 7: Humanize Your Process](https://dfrlbook.com/chapter7)

### Personas Non Grata
In addition to user personas, create a "dark persona" — a bad actor who could misuse your product. Explicitly list their goals and motivations, then design to hamper them.

**Source:** [Future Ethics with Cennydd Bowles at SustainableUX](https://ethical.net/ethical/future-ethics-with-cennydd-bowles-at-sustainableux/) (Ethical.net); [*Future Ethics*](https://cennydd.com/future-ethics) by Cennydd Bowles.

---

## Platform Guidelines

When you've recognized the issues using personas, look up the specific guidelines for your platform:

- **Web:** [Web Content Accessibility Guidelines (WCAG) 2.2](https://www.w3.org/TR/WCAG22/)
- **Android / Material Design:** [Accessibility — Material Design 3](https://m3.material.io/foundations/designing/overview)
- **Windows:** [Accessibility — Windows apps](https://learn.microsoft.com/en-us/windows/apps/design/accessibility/accessibility)
- **iOS / macOS:** [Accessibility | Apple Developer Documentation](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- **Linux / Ubuntu:** [Check your interface for accessibility](https://documentation.ubuntu.com/project/contributors/check-accessibility/)

---

## Quick Checklists

### Web Development
- [ ] Semantic HTML: use `<header>`, `<nav>`, `<main>`, `<article>`, `<footer>` correctly
- [ ] All images have meaningful `alt` text (decorative images use `alt=""`)
- [ ] All form inputs have associated `<label>` elements
- [ ] Heading hierarchy is logical (`h1` → `h2` → `h3`) with no skips
- [ ] Keyboard navigation works for all interactive elements (Tab, Enter, Space, Escape)
- [ ] Focus indicators are visible
- [ ] Color contrast meets WCAG AA (4.5:1 for normal text, 3:1 for large text)
- [ ] Text can be resized up to 200% without loss of content or functionality
- [ ] All video has captions; all audio has transcripts
- [ ] No information is conveyed by color alone
- [ ] ARIA roles, states, and properties are used correctly (and only when HTML semantics are insufficient)
- [ ] Skip links are provided for keyboard users

### Mobile Development
- [ ] Touch targets are at least 44x44 pt (iOS) or 48x48 dp (Android)
- [ ] Screen reader labels are meaningful and concise (VoiceOver / TalkBack)
- [ ] Dynamic Type / font scaling is supported
- [ ] Reduce Motion preferences are respected
- [ ] Voice Control / Switch Control navigation is tested
- [ ] High contrast modes are supported
- [ ] Landscape and portrait orientations both work
- [ ] No auto-playing audio without user control

### Content & Copy
- [ ] Use plain language; avoid idioms and metaphors
- [ ] Write descriptive link text (not "click here")
- [ ] Error messages explain what went wrong *and* how to fix it
- [ ] Required form fields are marked clearly *before* submission
- [ ] Instructions don't rely on sensory characteristics alone (e.g., "the red button")

---

## Further Reading

- [*A Web for Everyone—Designing Accessible User Experiences*](https://rosenfeldmedia.com/books/a-web-for-everyone/) by Sarah Horton and Whitney Quesenbery
- [*What Every Engineer Should Know About Digital Accessibility*](https://www.routledge.com/What-Every-Engineer-Should-Know-About-Digital-Accessibility/Horton-Sloan/p/book/9781032263861) by Sarah Horton and David Sloan
- [*Design for Real Life*](https://dfrlbook.com/) by Eric Meyer and Sara Wachter-Boettcher
- [*Future Ethics*](https://cennydd.com/future-ethics) by Cennydd Bowles
- [Web Content Accessibility Guidelines (WCAG) 2.2](https://www.w3.org/TR/WCAG22/)
- [Know About Accessibility](https://knowaboutaccessibility.org/) — companion website with free personas
- [This Is All There Is](http://www.breakingthin.gs/this-is-all-there-is.html) by Aral Balkan
- [10 Usability Heuristics for User Interface Design](https://www.nngroup.com/articles/ten-usability-heuristics/) by Jakob Nielsen
- ["Recognise" presentation by Alan Dalton](https://youtube.com/watch?v=rm5Ag6x-dRo&list=PLsaoWzR87FsUvLEI7xjThSdIB5TqMrOc0&index=3) at IxDA Dublin Defuse 2025

---

*This skill was compiled from research into the article and its linked resources. Always refer to the original sources for the full context.*
