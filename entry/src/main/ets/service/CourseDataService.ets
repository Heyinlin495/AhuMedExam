import { VideoItem } from '../model/VideoItem'

// 课程详情接口 - 统一的课程数据模型
export interface CourseDetail {
  id: number
  title: string
  description: string
  imageResource: Resource
  videoPath: string
  intro: string
  goals: string[]
  audience: string
}

// 课程数据服务 - 单一数据源
export class CourseDataService {
  private static courseList: CourseDetail[] = [
    {
      id: 1,
      title: '医考宝典-脾脏触诊',
      description: '医考脾脏触诊学习视频：深入讲解关键内容。双手触诊时，检查者左手放于患者左腰部...',
      imageResource: $r('app.media.course1'),
      videoPath: '1.脾脏触诊.mp4',
      intro: '脾脏触诊是医考体格检查中的重点考核项目。本视频由资深临床教师亲自示范，从体位摆放、手指定位、触诊力度到注意事项，逐一分解讲解。',
      goals: [
        '掌握脾脏触诊的标准体位与手法',
        '了解脾脏肿大的分度标准（轻度、中度、高度）',
        '熟悉触诊过程中的注意事项与常见错误',
        '能够准确描述脾脏触诊结果'
      ],
      audience: '临床医学生、住院医师规范化培训学员、执业医师资格考试备考人员'
    },
    {
      id: 2,
      title: '医考宝典-小儿急性阑尾炎',
      description: '小儿急性阑尾炎是小儿最常见的急腹症，也是医考中的重要内容...',
      imageResource: $r('app.media.course2'),
      videoPath: '2.小儿急性阑尾炎.mp4',
      intro: '小儿急性阑尾炎是小儿外科最常见的急腹症，由于小儿解剖生理特点，其临床表现与成人有显著差异，误诊率较高。本视频从病因病理、临床分型、诊断要点到治疗原则进行全面讲解。',
      goals: [
        '掌握小儿急性阑尾炎的病理分型',
        '理解小儿与成人阑尾炎的临床差异',
        '熟悉小儿阑尾炎的诊断要点与鉴别诊断',
        '了解手术时机选择及围手术期处理原则'
      ],
      audience: '儿科方向医学生、外科住院医师、医考备考人员'
    },
    {
      id: 3,
      title: '医考宝典-溶血性贫血',
      description: '医考学习视频之溶血性贫血：本视频全面深入讲解溶血性贫血这一重要病症...',
      imageResource: $r('app.media.course3'),
      videoPath: '3.溶血性贫血.mp4',
      intro: '溶血性贫血是由于红细胞破坏增多、超过骨髓代偿能力而引起的一类贫血。本视频按照病因分类，系统讲解各类溶血性贫血的发病机制、临床特征、实验室检查及治疗原则。',
      goals: [
        '掌握溶血性贫血的分类与病因',
        '理解血管内溶血与血管外溶血的区别',
        '熟悉常用实验室检查的临床意义',
        '了解各类溶血性贫血的治疗原则'
      ],
      audience: '内科方向医学生、血液科进修医师、医考备考人员'
    },
    {
      id: 4,
      title: '医考宝典-心律失常',
      description: '医考学习视频之心律失常：该视频系统讲解心律失常这一常见且重要的心脏病症...',
      imageResource: $r('app.media.course4'),
      videoPath: '4.心律失常.mp4',
      intro: '心律失常是心血管内科的核心内容，也是医考的高频考点。本视频从心脏电生理基础出发，系统讲解各类心律失常的发生机制，重点结合心电图图形特征进行分析。',
      goals: [
        '掌握常见心律失常的心电图特征',
        '理解心律失常的电生理机制',
        '熟悉抗心律失常药物的分类与选用',
        '能够识别和处理危急心律失常'
      ],
      audience: '临床医学生、心内科进修医师、急诊科医师、医考备考人员'
    },
    {
      id: 5,
      title: '医考宝典-胃癌的扩散与转移',
      description: '医考学习视频之胃癌的扩散与转移：此视频聚焦胃癌这一重大疾病的扩散和转移...',
      imageResource: $r('app.media.course5'),
      videoPath: '5.胃A的扩散与转移.mp4',
      intro: '胃癌是我国高发的消化道恶性肿瘤，了解其扩散与转移规律对临床诊治具有重要意义。本视频详细讲解胃癌的四种扩散方式：直接浸润、淋巴转移、血行转移和种植转移。',
      goals: [
        '掌握胃癌的四种扩散转移途径',
        '了解胃癌淋巴转移的分站标准',
        '熟悉胃癌TNM分期系统',
        '认识胃癌特殊转移的临床表现'
      ],
      audience: '外科方向医学生、肿瘤科医师、消化内科医师、医考备考人员'
    },
    {
      id: 6,
      title: '医考宝典-骨科真题',
      description: '医考学习视频之骨科真题，是医考备考的重要学习资源，涵盖历年各类骨科医学考试真题...',
      imageResource: $r('app.media.course6'),
      videoPath: '6.骨科真题.mp4',
      intro: '骨科是医考中外科学的重要组成部分，分值占比较高。本视频精选历年真题，按照骨折总论、上肢骨折、下肢骨折、关节脱位、脊柱与骨盆损伤等章节进行分类讲解。',
      goals: [
        '掌握骨科常见疾病的诊断要点',
        '熟悉各类骨折的分型与治疗原则',
        '了解骨科真题的出题规律与解题技巧',
        '能够准确鉴别骨科易混淆知识点'
      ],
      audience: '医考备考人员、骨科方向医学生、外科住院医师'
    },
    {
      id: 7,
      title: '医考宝典-消化系统真题',
      description: '医考学习视频之消化系统真题，是医考备考的重要辅助资料，消化系统在医考中占比重大...',
      imageResource: $r('app.media.course7'),
      videoPath: '7.消化系统真题.mp4',
      intro: '消化系统是医考中内容最多、分值最高的系统之一，涵盖食管、胃、肠、肝、胆、胰等器官疾病。本视频按照系统分类精选高频真题，对每道题目进行深入剖析。',
      goals: [
        '系统掌握消化系统常见疾病的诊疗要点',
        '熟悉消化系统真题的命题规律',
        '能够准确进行消化系统疾病的鉴别诊断',
        '了解消化系统最新诊疗进展'
      ],
      audience: '医考备考人员、消化内科方向医学生、普外科住院医师'
    }
  ]

  // 获取所有课程
  static getAllCourses(): CourseDetail[] {
    return CourseDataService.courseList
  }

  // 根据索引获取课程
  static getCourseByIndex(index: number): CourseDetail | null {
    if (index >= 0 && index < CourseDataService.courseList.length) {
      return CourseDataService.courseList[index]
    }
    return null
  }

  // 获取视频列表项（用于首页）
  static getVideoItems(): VideoItem[] {
    return CourseDataService.courseList.map((item: CourseDetail): VideoItem => ({
      title: item.title,
      description: item.description,
      imageResource: item.imageResource,
      videoPath: item.videoPath
    }))
  }
}
