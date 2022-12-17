/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Sergey Salnikov
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPCurveData
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPCurveData();
  QCPCurveData(double t, double key, double value);

  double sortKey() const;
  static QCPCurveData fromSortKey(double sortKey);
  static bool sortKeyIsMainKey();

  double mainKey() const;
  double mainValue() const;

  QCPRange valueRange() const;

  double t;
  double key;
  double value;
};


typedef QCPAbstractPlottable1D<QCPCurveData> QCPAbstractPlottable1D_QCPCurveData;
typedef QCPDataContainer<QCPCurveData> QCPCurveDataContainer;
typedef QCPDataContainerIterator<QCPCurveData> QCPCurveDataContainerIterator;


class QCPCurve : public QCPAbstractPlottable1D_QCPCurveData
{
%TypeHeaderCode
#include <qcustomplot.h>

typedef QCPAbstractPlottable1D<QCPCurveData> QCPAbstractPlottable1D_QCPCurveData;
%End
public:
  enum LineStyle { lsNone  ///< No line is drawn between data points (e.g. only scatters)
                   ,lsLine ///< Data points are connected with a straight line
                 };

  // Ownership acquired by QCustomPlot tied to the axis
  explicit QCPCurve(QCPAxis *keyAxis, QCPAxis *valueAxis) /Transfer/;
  virtual ~QCPCurve();

  // getters:
  QCPCurveDataContainer *data() const;
  %MethodCode
    sipRes = sipCpp->data().data();
  %End
  QCPScatterStyle scatterStyle() const;
  int scatterSkip() const;
  LineStyle lineStyle() const;

  // setters:
  void setData(QCPCurveDataContainer *data);
  %MethodCode
    sipCpp->setData(QSharedPointer<QCPCurveDataContainer>(a0));
  %End
  void setData(const QVector<double> &t, const QVector<double> &keys, const QVector<double> &values, bool alreadySorted=false);
  void setData(const QVector<double> &keys, const QVector<double> &values);
  void setScatterStyle(const QCPScatterStyle &style);
  void setScatterSkip(int skip);
  void setLineStyle(LineStyle style);

  // non-property methods:
  void addData(const QVector<double> &t, const QVector<double> &keys, const QVector<double> &values, bool alreadySorted=false);
  void addData(const QVector<double> &keys, const QVector<double> &values);
  void addData(double t, double key, double value);
  void addData(double key, double value);

  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  virtual QCPRange getKeyRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth) const;
  virtual QCPRange getValueRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange()) const;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual void drawLegendIcon(QCPPainter *painter, const QRectF &rect) const;

  // introduced virtual methods:
  virtual void drawCurveLine(QCPPainter *painter, const QVector<QPointF> &lines) const;
  virtual void drawScatterPlot(QCPPainter *painter, const QVector<QPointF> &points, const QCPScatterStyle &style) const;

  // non-virtual methods:
  void getCurveLines(QVector<QPointF> *lines, const QCPDataRange &dataRange, double penWidth) const;
  void getScatters(QVector<QPointF> *scatters, const QCPDataRange &dataRange, double scatterWidth) const;
  int getRegion(double key, double value, double keyMin, double valueMax, double keyMax, double valueMin) const;
  QPointF getOptimizedPoint(int otherRegion, double otherKey, double otherValue, double key, double value, double keyMin, double valueMax, double keyMax, double valueMin) const;
  QVector<QPointF> getOptimizedCornerPoints(int prevRegion, int currentRegion, double prevKey, double prevValue, double key, double value, double keyMin, double valueMax, double keyMax, double valueMin) const;
  bool mayTraverse(int prevRegion, int currentRegion) const;
  bool getTraverse(double prevKey, double prevValue, double key, double value, double keyMin, double valueMax, double keyMax, double valueMin, QPointF &crossA, QPointF &crossB) const;
  void getTraverseCornerPoints(int prevRegion, int currentRegion, double keyMin, double valueMax, double keyMax, double valueMin, QVector<QPointF> &beforeTraverse, QVector<QPointF> &afterTraverse) const;
//   double pointDistance(const QPointF &pixelPoint, QCPCurveDataContainerIterator &closestData) const;
};
