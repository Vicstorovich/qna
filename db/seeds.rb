Course.create!([
  {name: "Course five", image: nil, user_id: 20},
  {name: "Ciurse MMM", image: nil, user_id: 20}
])
Homework.create!([
  {body: "tarabara2", lesson_id: 3},
  {body: "787878787", lesson_id: 3},
  {body: "qwqwqwqw", lesson_id: 3},
  {body: "W2222222", lesson_id: 4},
  {body: "Xxxxxxx", lesson_id: 5},
  {body: "Ccccccccc", lesson_id: 5}
])
Lesson.create!([
  {title: "Lesson 1", description: "Описание", conspectus: "Про занятие", homework: "Домашка", image: "1269217_1_1.jpg", video: "pornona.net-8657we25186228841.mp4", course_id: 27, draft: false, selector: 0},
  {title: "Lesson 2", description: "Deccription", conspectus: "Conspectus", homework: "Homework", image: "rails_commands_1920x1080.jpg", video: "Любопытный_хлопец_перед_сексом_ковыряется_пальцами_в_зрелой_.mp4", course_id: 27, draft: false, selector: 0},
  {title: "Lesson 3", description: "Qqqqqqqqq", conspectus: "Qqqqqqqq", homework: "1www\r\n2sssss", image: "1707717_1.jpg", video: "pornona.net-18285214355994215157141.mp4", course_id: 27, draft: false, selector: 0}
])
User.create!([
  {email: "user1@1.ru", encrypted_password: "05644da758c0d93620341e1c70a59d45", active: true},
  {email: "user2@2.ru", encrypted_password: "2827a9f5e3df24e73e91ff391b3323e6", active: true},
  {email: "mmm22@mail.ru", encrypted_password: "261046bf3a83b1842029ceb127201ce8", active: true},
  {email: "mmm2@mail.ru", encrypted_password: "05644da758c0d93620341e1c70a59d45", active: true},
  {email: "m@mail.ru", encrypted_password: "9c23a94a982c2fb2842729afa80370f7", active: true}
])
