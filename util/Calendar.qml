import Quickshell
pragma Singleton


Singleton {
   id:cal
    property var date: new Date()
    readonly property real month: cal.date.getMonth()
    readonly property real year: cal.date.getFullYear()




    function setDate(d) {
        if (cal.date.getTime() === d.getTime()) return;
        cal.date = d;

    }
    function shiftMonth(delta) {
 

      setDate(new Date(cal.year, cal.month + delta, 1));
   }

   function reset() {
      setDate(new Date());
   }
   readonly property var layout: {
        const year = cal.year;
        const month = cal.month;
        const now = new Date();
        const startOfMonth = new Date(year, month, 1);
        const startDayOfWeek = (startOfMonth.getDay() + 0) % 7;

      const days = [];

      const currentIterDate = new Date(year, month, 1 - startDayOfWeek);

      for (let i = 0; i < 42; i++) {
         const isToday =
            currentIterDate.getDate() === now.getDate() &&
            currentIterDate.getMonth() === now.getMonth() &&
            currentIterDate.getFullYear() === now.getFullYear();

         days.push({
            date: new Date(currentIterDate),
            day: currentIterDate.getDate(),
            isToday,
            isWeekend:
               currentIterDate.getDay() === 0 || currentIterDate.getDay() === 6,
            isOtherMonth: currentIterDate.getMonth() !== month,
         });

         currentIterDate.setDate(currentIterDate.getDate() + 1);
      }

      const weeks = [];
      for (let i = 0; i < 6; i++) {
         weeks.push(days.slice(i * 7, (i + 1) * 7));
      }

      return weeks;
   }

}
