/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Sergey Salnikov
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */

class QCPAxisTickerDateTime : public QCPAxisTicker
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPAxisTickerDateTime();

  // getters:
  QString dateTimeFormat() const;
  Qt::TimeSpec dateTimeSpec() const;
  QTimeZone timeZone() const;

  // setters:
  void setDateTimeFormat(const QString &format);
  void setDateTimeSpec(Qt::TimeSpec spec);
  void setTimeZone(const QTimeZone &zone);
  void setTickOrigin(double origin); // hides base class method but calls baseclass implementation ("using" throws off IDEs and doxygen)
  void setTickOrigin(const QDateTime &origin);

  // static methods:
  static QDateTime keyToDateTime(double key);
  static double dateTimeToKey(const QDateTime dateTime);
  static double dateTimeToKey(const QDate &date, Qt::TimeSpec timeSpec=Qt::LocalTime);

protected:
  // reimplemented virtual methods:
  virtual double getTickStep(const QCPRange &range);
  virtual int getSubTickCount(double tickStep);
  virtual QString getTickLabel(double tick, const QLocale &locale, QChar formatChar, int precision);
  virtual QVector<double> createTickVector(double tickStep, const QCPRange &range);
};
